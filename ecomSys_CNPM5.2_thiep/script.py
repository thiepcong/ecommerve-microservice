import subprocess
import os

services = [
    'cart',
    'order',
    'payment',
    'products',
    'search',
    'shipment',
    'user'
]
ports = [
    4004,  
    4005, 
    4007, 
    4002, 
    4003, 
    4006, 
    4001
]

# Run each project
for service, port in zip(services, ports):
    command = f"py {service}/manage.py runserver {port}"
    subprocess.Popen(command, shell=True)

print("All Django projects have been started.")
