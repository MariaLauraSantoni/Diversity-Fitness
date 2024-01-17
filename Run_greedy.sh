#!/bin/bash

#SBATCH --job-name=1w
#SBATCH --array=0-##jobs_count##
#SBATCH --clusters=serial
#SBATCH --partition=serial_std
#SBATCH --mem=2048MB
#SBATCH --time=72:00:00
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
    # Crea una cartella per ogni esecuzione
    cd results_$function/run_$run
    cp ${function}_output.txt ../../
    cd ../../
    # Definisci gli argomenti per lo script Python
    #function="1"
    instance="0"
    dimension="2"
    initial_size="10000"
    best_size="5"
    lb="-5"
    ub="5"
    iterations="1000"
    cd my_results_$function
    mkdir run_$run
    cd ..

    # Esegui lo script Python con gli argomenti
    python main_on_other_alg.py "$function" "$instance" "$dimension" "$initial_size" "$best_size" "$lb" "$ub" "$iterations"
    mv ${function}_my* my_results_$function/run_$run
    #mv dist* results_$function/run_$run
    rm -rf ${function}_output.txt
done
