import re
import math
import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

samplePeriod = 1 / 256
pattern = re.compile(r'[-\.\d]+')

ori = []
with open("./vivo_gt1_test_video/orientations.txt", "r") as f:
    for x in f:
        result = pattern.findall(x)
        if len(result)==4:
            ori.append(float(result[0]))

#filtCutOff = 5
#b, a = signal.butter(1, (2*filtCutOff)/(1/samplePeriod), 'lowpass')
#ori_filt = signal.filtfilt(b, a, ori, padtype = 'odd', padlen=0) 

# get step vector
stepx = []
stepy = []
for o in ori:
    rad = math.radians(o)
    stepx.append(math.cos(rad) - math.sin(rad))
    stepy.append(math.sin(rad) + math.cos(rad))


sensor0 = []
sensor1 = []
sensor2 = []
sensor3 = []
with open("./vivo_gt1_test_video/accelerometer.txt", "r") as f:
    for x in f:
        result = pattern.findall(x)

        if len(result)==4:
            sensor0.append(float(result[0]))
            sensor1.append(float(result[1]))
            sensor2.append(float(result[2]))
            sensor3.append(float(result[3]))
# filter
filtCutOff = 5
b, a = signal.butter(1, (2*filtCutOff)/(1/samplePeriod), 'lowpass')
acc_magFilt = signal.filtfilt(b, a, sensor0, padtype = 'odd', padlen=0) 

f_acc = []
flag = True
for i in range(0, len(acc_magFilt)-2):
    if acc_magFilt[i+2] - acc_magFilt[i+1] > 0 and acc_magFilt[i+1] - acc_magFilt[i] < 0:
        f_acc.append(1)
    else:
        f_acc.append(0)
f_acc.append(0)
f_acc.append(0)

# now get traj
trajx = np.zeros((len(stepx),), dtype = float) 
trajy = np.zeros((len(stepx),), dtype = float) 

for i in range(1, len(stepx)-3):
    if f_acc[i]:
        trajx[i] = stepx[i] + trajx[i-1]
        trajy[i] = stepy[i] + trajy[i-1]
    else:
        trajx[i] = trajx[i-1]
        trajy[i] = trajy[i-1]

# custom name
times = sensor3
g1 = sensor0
g2 = sensor1
g3 = sensor2
fig, (ax, ax1) = plt.subplots(2,1)
ax.plot(times, acc_magFilt)
ax.plot(times, g1)
ax.plot(times, f_acc)
ax1.plot(trajx, trajy)
plt.show()
