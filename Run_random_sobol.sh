#!/bin/bash

#SBATCH --job-name=f1g10
#SBATCH --array=0-##jobs_count##
#SBATCH --clusters=serial
#SBATCH --partition=serial_std
#SBATCH --time=96:00:00
#SBATCH --mail-user=your_email@domain.com
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=script.out
#SBATCH --err=script.err


import sys

function="24"

mkdir my_results_$function
for run in {1..10}; do
    # Definisci gli argomenti per lo script Python
    #function="1"
    instance="0"
    dimension="5"
    initial_size="200"
    best_size="5"
    lb="-5"
    ub="5"
    iterations="1000"
    cd my_results_$function
    mkdir run_$run
    cd ..

    # Esegui lo script Python con gli argomenti
    python main_random.py "$function" "$instance" "$dimension" "$initial_size" "$best_size" "$lb" "$ub" "$iterations"
    mv ${function}_* my_results_$function/run_$run
done
