import sys
import re
import argparse
import numpy as np
from datetime import datetime, timedelta

def remove_outliers(x, outlierConstant = 1.5):
    a = np.array(x)
    upper_quartile = np.percentile(a, 75)
    lower_quartile = np.percentile(a, 25)
    IQR = (upper_quartile - lower_quartile) * outlierConstant
    quartileSet = (lower_quartile - IQR, upper_quartile + IQR)
    resultList = []
    removedList = []
    for y in a.tolist():
        if y >= quartileSet[0] and y <= quartileSet[1]:
            resultList.append(y)
        else:
            removedList.append(y)
    return (resultList, removedList)

def str2datetime(s):
    parts = s.split('.')
    dt = datetime.strptime(parts[0], "%Y-%m-%d %H:%M:%S")
    return dt.replace(microsecond=int(parts[1]))


def plot_thr(fname):
    import matplotlib.pyplot as plt
    x = range(len(values))
    y = values
    plt.xlabel(r"time")
    plt.ylabel(r"tx/sec")
    plt.plot(x, y)
    plt.show()
    plt.savefig(fname)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--interval', type=float, default=1, required=False)
    parser.add_argument('--output', type=str, default="hist.png", required=False)
    parser.add_argument('--plot', action='store_true')
    args = parser.parse_args()
    computation_pat = re.compile('([^[].*) \[hotstuff computation info\] ([0-9.]*)$')
    # cmd_pat = re.compile('([^[].*) \[hotstuff cmd info\] ([0-9.]*)$')
    # circle_pat = re.compile('([^[].*) the circle size is: ([0-9.]*)$')
    interval = args.interval
    cnt = 0
    computation_lats = []
    # cmd_transfer_lats = []
    timestamps = []
    values = []
    # circle_sz = []
    for line in sys.stdin:
        computation_m = computation_pat.match(line)
        if computation_m:
            computation_lats.append(float(computation_m.group(2)))
        # cmd_m = cmd_pat.match(line)
        # if cmd_m:
        #     cmd_transfer_lats.append(float(cmd_m.group(2)))
        # circle_m = circle_pat.match(line)
        # if circle_m:
        #     circle_sz.append(float(circle_m.group(2)))

    if len(computation_lats) == 0:
        print("len(computation_lats == 0)")
    else:
        print("computation_lat = {:.3f}ms".format(sum(computation_lats) / len(computation_lats) * 1e3))
        computation_lats, _ = remove_outliers(computation_lats)
        print("computation_lat after remove_outliers = {:.3f}ms".format(sum(computation_lats) / len(computation_lats) * 1e3))

    # if len(cmd_transfer_lats) == 0:
    #     print("len(cmd_transfer_lats == 0)")
    # else:
    #     print("cmd_lat = {:.3f}ms".format(sum(cmd_transfer_lats) / len(cmd_transfer_lats) * 1e3))
    #     cmd_transfer_lats, _ = remove_outliers(cmd_transfer_lats)
    #     print("cmd_lat after remove_outliers = {:.3f}ms".format(sum(cmd_transfer_lats) / len(cmd_transfer_lats) * 1e3))

    # print("circle_size = {:.3f}".format(sum(circle_sz) / len(circle_sz)))
    # circle_sz, _ = remove_outliers(circle_sz)
    # print("circle_size after remove_outliers = {:.3f}".format(sum(circle_sz) / len(circle_sz)))


    if args.plot:
        plot_thr(args.output)
