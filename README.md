# Illuminating the Diversity-Fitness Trade-Off in Black-Box Optimization
This repository contains the code used to generate the results in the paper Illuminating the Diversity-Fitness Trade-Off in Black-Box Optimization.

It proposes python code to run the experiments illustrated in the paper. In particular, the greedy approach starting from a random sample, a sobol sequence, and evaluations from selected algorithms
via [IOHprofiler](https://iohprofiler.github.io/), and appropriate code to store all the data obtained.
The selected algorithms are and the code packages used for the random sample and the sobol sequence are: 
- CMA-ES from the [pycma](https://github.com/CMA-ES/pycma) package.
- HillVallEA algorithm from [Benchmarking HillVallEA for the GECCO 2019
Competition on Multimodal Optimization](https://arxiv.org/pdf/1907.10988.pdf).
- RS-CMSAII) introduced in [Static and Dynamic Multimodal Optimization by Improved Covariance Matrix Self-Adaptation Evolution Strategy With Repelling Subpopulations](https://ieeexplore.ieee.org/document/9555836).
- WGraD proposed in [Niche Method Complementing the Nearest-better Clustering](https://ieeexplore.ieee.org/document/9002742).
- Random sample, taken from the Python module numpy using the method [random.uniform](https://numpy.org/doc/stable/reference/random/generated/numpy.random.uniform.html).
- Sobol sequence taken from the Python package sobol_seq using the method [i4_sobol_generate](https://pypi.org/project/sobol/).


This code runs the greedy approach presented in the paper starting from these sample sets on the 24 functions of the Black-Box Optimization Benchmarking (BBOB) suite from the [COCO](https://arxiv.org/pdf/1603.08785.pdf) benchmarking environment suite using their definition from [IOHprofiler](https://iohprofiler.github.io/). The code to run the selected algorithms and to have the initial sets are taken from [CMA-ES](https://github.com/CMA-ES/pycma), [HillVallEA](https://github.com/SCMaree/HillVallEA), [RS-CMSA](https://www.researchgate.net/publication/357877953_Python_code_RS-CMSA-ESII), [WGraD](https://github.com/yuhaoli-95/WGraD), [random search](https://numpy.org/doc/stable/reference/random/generated/numpy.random.uniform.html) and [sobol_seq](https://pypi.org/project/sobol/). Moreover, it contains also the Python code to solve the MILP problem explained in the paper through Gurobi. We provide all the Python files to run the paper experiments and to store results in data files.

# Libraries and dependencies

The implementation of all tasks and algorithms to perform experiments are in Python 3.7.4 and all the libraries used are listed in `requirements.txt`.
To use Gurobi a license is required, check the website [Gurobi](https://www.gurobi.com).


# Structure
- `run_experiment.py` is the main file, used to run any experiments. It initializes the main setting of the experiment, calls the chosen algorithm, and writes log files. It takes as argument a file `.json` that is the output of the file `gen_config.py`.
- `wrapper.py` contains the definition of all algorithms and the method `wrapopt` that runs the main loop of the chosen algorithm. It is called by the file `run_experiment.py`.
- `my_logger.py` defines all the functions needed to generate the files to store data output by a run. It is called by the file `run_experiment.py`.
- `total_config.json` allows defining the settings of the experiment and it has to be the argument of the file `gen_config.py`. 
- `gen_config.py` generates a folder called `config` containing files to run each algorithm with the parameters chosen in `total_config.json` given as an input and a bash script to run experiments with a Slurm job scheduler.
- `mylib` contains one folder for each algorithm with all the classes and functions needed to run them.
- `Bayesian-Optimization.zip` contains the cloned repository [Bayesian-Optimization](https://github.com/wangronin/Bayesian-Optimization/tree/KPCA-BO) with little changes to track the CPU time for the algorithms PCA-BO and KPCA-BO.
- `RDUCB.zip` contains the cloned repository [RDUCB](https://github.com/huawei-noah/HEBO/tree/master/RDUCB) with little changes to track the CPU time for the algorithm RDUCB.
- `Gpy.zip` and `GpyOpt.zip` contain the modules Gpy and GpyOpt, respectively, with little changes to track the CPU time for the algorithm RDUCB.
- `skopt.zip` contains the module skopt with little changes to track the CPU time for the algorithm vanilla Bayesian Optimization.
- `requirements.txt` contains the list of all the project’s dependencies with the specific version of each dependency.
