# ACO

The **ant colony optimization algorithm (ACO)** is a probabilistic technique for solving computational problems which can be reduced to finding good paths through graphs.
 
The first algorithm was aiming to search for an optimal path in a graph, based on the behavior of ants seeking a path between their colony and a source of food. The original idea has since diversified to solve a wider class of numerical problems, and as a result, several problems have emerged, drawing on various aspects of the behavior of ants. From a broader perspective, ACO performs a model-based search and share some similarities with Estimation of Distribution Algorithms.

## 基本思想

蚂蚁在寻找食物源时，会在其经过的路径上释放一种信息素，并能够感知其他蚂蚁释放的信息素。信息素浓度的大小表征路径的远近，信息素浓度越高，表示对应的路径距离越短。通常，蚂蚁会以较大的概率优先选择信息素浓度较高的路径，并释放一定量的信息素，以增强该条路径上的信息素浓度，这样会形成一个正反馈。最终，蚂蚁能够找到一条从巢穴到食物源的最佳路径，即最短距离。值得一提的是，生物学家同时发现，路径上的信息素浓度会随着时间的推进而逐渐衰减。

将蚁群算法应用于解决优化问题的基本思路是：用蚂蚁的行走路径表示待优化问题的可行解，整个蚂蚁群体的所有路径构成待优化问题的解空间。路径较短的蚂蚁释放的信息素量较多，随着时间的推进，较短的路径上累积的信息素浓度逐渐增高，选择该路径的蚂蚁个数也愈来愈多。最终，整个蚂蚁会在正反馈的作用下集中到最佳的路径上，此时对应的便是待优化问题的最优解。

