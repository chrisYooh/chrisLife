import numpy as np

values = np.array(\
[[0,1,1,1,0, 0,1,0,1,0, 0,1,0,1,0, 0,1,0,1,0, 0,1,1,1,0],\
[0,0,1,0,0, 0,1,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,1,1,1,0],\
[0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0, 0,1,0,0,0, 0,1,1,1,0],\
[0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0],\
[0,1,0,1,0, 0,1,0,1,0, 0,1,1,1,0, 0,0,0,1,0, 0,0,0,1,0],\
[0,1,1,1,0, 0,1,0,0,0, 0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0],\
[0,1,1,1,0, 0,1,0,0,0, 0,1,1,1,0, 0,1,0,1,0, 0,1,1,1,0],\
[0,1,1,1,0, 0,0,0,1,0, 0,0,0,1,0, 0,0,0,1,0, 0,0,0,1,0],\
[0,1,1,1,0, 0,1,0,1,0, 0,1,1,1,0, 0,1,0,1,0, 0,1,1,1,0],\
[0,1,1,1,0, 0,1,0,1,0, 0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0]])

spInput = np.array(\
[[1,1,1,0,0, 1,0,0,0,0, 1,1,1,0,0, 0,0,1,0,0, 1,1,1,0,0],\
[0,1,1,1,0, 0,1,0,0,0, 0,1,1,1,0, 0,0,0,1,0, 0,1,1,0,0],\
[0,0,1,1,0, 0,1,0,0,0, 0,1,1,1,0, 0,0,0,1,0, 0,1,1,1,0]])

result = []
for i in range(10):
#    v0 = values[9] * 2 - 1;
    v0 = spInput[2] * 2 - 1;
    v1 = values[i] * 2 - 1;
    ms = np.sum(v0 * v1);
    result.append(ms);

print(result)

    


