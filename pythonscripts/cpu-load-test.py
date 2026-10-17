
import requests
import time
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed

URL = "http://dev-app-alb-1578679150.ap-south-1.elb.amazonaws.com/"
TOTAL_REQUESTS = 1000000
CONCURRENCY = 2000
TIMEOUT = 10

success = 0
failed = 0
lock = threading.Lock()


def send_request(session, request_number):
    global success, failed

    try:
        response = session.get(URL, timeout=TIMEOUT)
        with lock:
            if response.ok:
                success += 1
            else:
                failed += 1

        return response.status_code

    except requests.RequestException as exc:
        with lock:
            failed += 1
        return str(exc)


def worker(request_numbers):
    # Each worker maintains its own HTTP session.
    # Connections can be reused within that worker.
    with requests.Session() as session:
        session.headers.update({
            "User-Agent": "DevOps-Racer-LoadTest/1.0",
            "Connection": "keep-alive",
        })

        return [
            send_request(session, number)
            for number in request_numbers
        ]


if __name__ == "__main__":
    batches = [
        range(start, min(start + 100, TOTAL_REQUESTS + 1))
        for start in range(1, TOTAL_REQUESTS + 1, 100)
    ]

    start_time = time.time()
    print(f"Target: {URL}")
    print(f"Requests: {TOTAL_REQUESTS}")
    print(f"Concurrent workers: {CONCURRENCY}")
    print("Starting load test...")

    with ThreadPoolExecutor(max_workers=CONCURRENCY) as executor:
        futures = [executor.submit(worker, batch) for batch in batches]

        for future in as_completed(futures):
            future.result()

            completed = success + failed
            if completed and completed % 500 < 100:
                print(
                    f"Completed: {completed}/{TOTAL_REQUESTS} | "
                    f"Success: {success} | Failed: {failed}"
                )

    elapsed = time.time() - start_time

    print("\n===== LOAD TEST RESULTS =====")
    print(f"Total requests: {TOTAL_REQUESTS}")
    print(f"Successful: {success}")
    print(f"Failed: {failed}")
    print(f"Duration: {elapsed:.2f} seconds")
    print(f"Throughput: {TOTAL_REQUESTS / elapsed:.2f} requests/sec")
