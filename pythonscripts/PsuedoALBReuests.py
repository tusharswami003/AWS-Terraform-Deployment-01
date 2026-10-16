import requests
import time

URL = "http://dev-app-alb-1578679150.ap-south-1.elb.amazonaws.com/"

TOTAL_REQUESTS = 10000

session = requests.Session()

start = time.time()

for i in range(1, TOTAL_REQUESTS + 1):
    try:
        response = session.get(URL, timeout=10)

        if i % 100 == 0:
            print(
                f"Requests: {i}/{TOTAL_REQUESTS} | "
                f"Status: {response.status_code}"
            )

    except requests.RequestException as e:
        print(f"Request {i} failed: {e}")

elapsed = time.time() - start

print("\nDone")
print(f"Total requests : {TOTAL_REQUESTS}")
print(f"Time taken     : {elapsed:.2f}s")
print(f"Requests/sec   : {TOTAL_REQUESTS / elapsed:.2f}")