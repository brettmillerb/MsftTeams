from setuptools import setup, find_packages
import json

with open('setup.json', 'r') as f:
    config = json.load(f)

setup(
    name=config['name'],
    version=config['version'],
    description=config['description'],
    author=config['author'],
    packages=find_packages(),
    install_requires=config['install_requires'],
    python_requires=config['python_requires'],
)
