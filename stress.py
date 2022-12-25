import multiprocessing
import time
import sys

def stresser():
    f = 4.6643
    while True:
        f = f * 4.6643 + 7.54276
    return

if __name__ == '__main__':
    try:
        time_stress = int(input("Enter the time in seconds for which you want to stress the CPU: "))
        cores_stress = min(int(input("Enter the number of cores you want to stress: ")), multiprocessing.cpu_count())
    except:
        print("Error: Invalid input")
        exit()

    jobs = []
    for i in range(cores_stress):
        p = multiprocessing.Process(target=stresser)
        jobs.append(p)
        p.start()
    print("Starting test...")
    for j in range(time_stress):
        time.sleep(1)
        sys.stdout.write('Time elapsed in seconds - %s\r' % str(j+1))
        sys.stdout.flush()

    print("Terminating test.")
    for j in range(len(jobs)):
        jobs[j].terminate()
