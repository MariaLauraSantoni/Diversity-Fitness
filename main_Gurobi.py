from gurobipy import Model, GRB, quicksum
import numpy as np


# Carica i pesi da un file txt (10000 pesi)
weights = np.loadtxt('12_0_2_10000_5_-5_5_1000_sample_values.txt', usecols=[0], skiprows=1)

# Carica le distanze da un file txt (10000 righe e 10000 colonne)
distances = np.loadtxt('distances.txt')

# Creazione del modello
model = Model()

# Crea le variabili binarie
num_var = len(weights)
var = model.addVars(num_var, vtype=GRB.BINARY, name="variable")
#distanza_vars = model.addVars([(i, j) for i in range(num_var) for j in range(i + 1, num_var)], vtype=GRB.INTEGER, name="distanza_var")

# Constants
# M is chosen to be as small as possible given the bounds on x and y
# eps = 0.0001
# M = 2 + eps
# Crea il vincolo per la distanza tra i punti
min_dist = 1  # Specifica il valore minimo di distanza
#dist_var = model.addVars(num_var, num_var, vtype=GRB.INTEGER, name='dist_var')
for i in range(num_var):
    for j in range(i + 1, num_var):
        #model.addConstr(dist_var[i,j] == var[i] + var[j])
        #model.addConstr((dist_var[i,j] == 2) >> (distances[i,j]>=min_dist))
        model.addConstr((2 - var[i] - var[j]) * min_dist + distances[i,j] >= min_dist)
# Crea il vincolo per la somma delle variabili
model.addConstr(var.sum() == 5, "sum_constraint")
# Crea la funzione obiettivo utilizzando le distanze
# Definisci la funzione obiettivo
objective = quicksum(var[i] * weights[i] for i in range(num_var))
model.setObjective(objective, GRB.MINIMIZE)

# Ottimizza il modello
model.optimize()

# Stampa i risultati
# Estrai i pesi corrispondenti alle variabili che sono 1 nella soluzione ottimale
optimal_solution = [var[i].x for i in range(num_var)]
optimal_weights = [weights[i] for i in range(num_var) if optimal_solution[i] == 1]

# Stampa i risultati
if model.status == GRB.OPTIMAL:
    # Estrai gli indici corrispondenti alle variabili che sono 1 nella soluzione ottimale
    optimal_indices = [i for i in range(num_var) if var[i].x == 1]

    results = f"Optimal value: {model.objVal}\nOptimal solution: {optimal_solution}\nOptimal weights: {optimal_weights}\nOptimal indices: {optimal_indices}"

    # Salva i risultati in un file
    with open('results_d1_f12.txt', 'w') as file:
        file.write(results)
else:
    print("The problem does not have a solution.")
