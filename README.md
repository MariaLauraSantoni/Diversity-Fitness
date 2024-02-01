# Illuminating the Diversity-Fitness Trade-Off in Black-Box Optimization
This repository contains the code used to generate the results in the paper Illuminating the Diversity-Fitness Trade-Off in Black-Box Optimization.

It proposes Python code to run the experiments illustrated in the paper. In particular, the greedy approach starting from a random sample, a sobol sequence, and evaluations from selected algorithms
via [IOHprofiler](https://iohprofiler.github.io/), and appropriate code to store all the data obtained.
The selected algorithms and the code packages used for the random sample and the Sobol sequence are: 
- CMA-ES from the [pycma](https://github.com/CMA-ES/pycma) package.
- HillVallEA algorithm from [Benchmarking HillVallEA for the GECCO 2019
Competition on Multimodal Optimization](https://arxiv.org/pdf/1907.10988.pdf).
- RS-CMSAII) introduced in [Static and Dynamic Multimodal Optimization by Improved Covariance Matrix Self-Adaptation Evolution Strategy With Repelling Subpopulations](https://ieeexplore.ieee.org/document/9555836).
- WGraD proposed in [Niche Method Complementing the Nearest-better Clustering](https://ieeexplore.ieee.org/document/9002742).
- Random sample, taken from the Python module numpy using the method [random.uniform](https://numpy.org/doc/stable/reference/random/generated/numpy.random.uniform.html).
- Sobol sequence taken from the Python package sobol_seq using the method [i4_sobol_generate](https://pypi.org/project/sobol/).


This code runs the greedy approach presented in the paper starting from these sample sets on the 24 functions of the Black-Box Optimization Benchmarking (BBOB) suite from the [COCO](https://arxiv.org/pdf/1603.08785.pdf) benchmarking environment suite using their definition from [IOHprofiler](https://iohprofiler.github.io/). The code to run the selected algorithms and to have the initial sets are taken from [CMA-ES](https://github.com/CMA-ES/pycma), [HillVallEA](https://github.com/SCMaree/HillVallEA), [RS-CMSA](https://www.researchgate.net/publication/357877953_Python_code_RS-CMSA-ESII), [WGraD](https://github.com/yuhaoli-95/WGraD), [random search](https://numpy.org/doc/stable/reference/random/generated/numpy.random.uniform.html) and [sobol_seq](https://pypi.org/project/sobol/). Moreover, it also contains the Python code to solve the MILP problem explained in the paper through Gurobi. We provide all the Python files to run the paper experiments and to store results in data files.

# Libraries and dependencies

The implementation of all tasks and algorithms to perform experiments are in Python 3.7.4 and all the libraries used are listed in `requirements.txt`.
To use Gurobi a license is required, check the website [Gurobi](https://www.gurobi.com).


# Structure
- `main_random.py` contains the code to run the greedy approach starting from a random sample.
- `main_sobol.py` contains the code to run the greedy approach starting from a random sample.
- `main_on_other_alg.py` contains the code to run the greedy approach starting from a sample of evaluations loaded from a pre-existed txt file.
- `main_Gurobi.py` contains the code to define and solve the MILP problem with Gurobi. 
- `Run_random_sobol.sh` is a Slurm job script for the Linux cluster environment. The script has a loop to run main_random.py or main_sobol.py multiple times with different parameters.
- `Run_greedy.sh` is a Slurm job script for the Linux cluster environment. There is a loop within the script to run main_on_other_alg.py multiple times with different parameters.
- `Run_Gurobi.sh` is a Slurm job script for the Linux cluster environment. It loads the Gurobi license and runs main_Gurobi.py.
- `requirements.txt` contains the list of all the project’s dependencies with the specific version of each dependency.

# Execution from source
## Dependencies to run from source

Running this code from source requires Python 3.7.4, and the libraries given in `requirements.txt` (Warning: preferably use a virtual environment for this specific project, to avoid breaking the dependencies of your other projects). In Ubuntu, installing the dependencies can be done using the following command:

```
pip install -r requirements.txt
```

## Run from source
### Execute a single run
- `main_random.py`: Input files: no input files. Comment lines 177-184, uncomment lines 186-193 and insert the setting to run the algorithm with (inp1 = a function from 1 to 24, inp2 = instance of the function, inp3 = dimension of the problem, inp4 = initial size (T), inp5 = batch size (k), inp6 = lower bound (-5 for the BBOB functions), inp7 = upper bound (5 for the BBOB functions), inp8 = iterations (M)). Output files: inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8_sample_values.txt (two columns, in the first columns there are the fitness values of the function evaluated on the initial random sample ordered in a crescent order, in the second column there are the respective points), inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8.txt (two columns containing the minimum distance and the average loss respectively at each iteration of the greedy), distances.txt (a matrix containing the pairwise euclidean distance between each couple of points in the initial set after being ordered according to the fitness values).
  A single run with specific settings can be executed using the following command:
  ```
  python main_random.py
  ```
- `main_sobol.py`: Same as `main_random.py` but it does not generate distances.txt.
  A single run with specific settings can be executed using the following command:
  ```
  python main_sobol.py
  ```
- `main_on_other_alg.py`: Input files: inp1_output.txt (the history of the chosen algorithm, two columns containing the fitness values and the points respectively. Change lines 40-49, and 52 according to the dimension of the problem. Comment lines 177-184, uncomment lines 186-193 and insert the setting to run the algorithm with (inp1 = a function from 1 to 24, inp2 = instance of the function, inp3 = dimension of the problem, inp4 = initial size (T), inp5 = batch size (k), inp6 = lower bound (-5 for the BBOB functions), inp7 = upper bound (5 for the BBOB functions), inp8 = iterations (M)). Output files: inp1_my_best_batch.txt (the best batch of points selected at each iteration of the greedy algorithm). inp1_my_inp2_inp3_inp4_inp5_inp6_inp7_inp8.txt (two columns containing the minimum distance and the average loss respectively at each iteration of the greedy).
  A single run with specific settings can be executed using the following command:
  ```
  python main_on_other_alg.py
  ```
- `main_Gurobi.py`: Input files: inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8_sample_values.txt and distances.txt generated from `main_random.py`. Change lines 6 (with the correct inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8_sample_values.txt) and line 54 (with the name of the output file (.txt), not imposed choice here). Change line 24 with the distance you want to impose. Output files: chosen_name.txt (Optimal value of the problem, Optimal solution, Optimal weights, optimal indices of the points stored in inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8_sample_values.txt (index +2= corresponding points in inp1_inp2_inp3_inp4_inp5_inp6_inp7_inp8_sample_values.txt).
  A single run with specific settings can be executed using the following command:
  ```
  python main_Gurobi.py
  ```
### Execute repetitions in parallel using a cluster
If a job scheduling system for Linux clusters is available, the batch scripts can be edited and executed. 
- `Run_random_sobol.sh`: Change the settings to run (function, instance, dimension, initial_size, best_size, lb, ub, iterations. Change the number of independent runs to do (if  `main_sobol.py` only 1 run should be done since it is deterministic). Put `main_random.py` or `main_sobol.py` in line 36. Output files: a folder my_results_function containing a folder for each run (run_1, run_2...) with the respective output files from `main_random.py` or `main_sobol.py`.
- `Run_greedy.sh`:
- `Run_Gurobi.sh`:
