<h3 align=center>Prefect Docker Template</h3>
<p align=center>
  <span>Template for provisioning prefect in a docker container.</span>
  <br>
  <br>
  <a target="_blank" href="https://www.docker.com/" title="Docker">
    <img src="https://img.shields.io/badge/-docker-blue">
  </a>
  <a target="_blank" href="https://www.docker.com/" title="Docker">
    <img src="https://img.shields.io/badge/-docker--compose-blue">
  </a>
  <a target="_blank" href="https://www.python.org/downloads/" title="Python">
    <img src="https://img.shields.io/badge/python-%3E=_3.10-green.svg">
  </a>
  <a target="_blank" href="https://www.prefect.io/" title="Prefect">
    <img src="https://img.shields.io/badge/prefect-2.6.9-violet">
  </a>
  <a target="_blank" href="https://github.com/freshstartagain/prefect-docker-template/actions/workflows/code_quality.yml" title="Code Quality">
    <img src="https://github.com/freshstartagain/prefect-docker-template/actions/workflows/code_quality.yml/badge.svg">
  </a>
</p>

<p align="center">
  <a href="#installation">Installation</a>
</p>

## Installation 

```console
# clone repo
git git@github.com:freshstartagain/prefect-docker-template.git

# rename directory
mv prefect-docker-template <name-of-your-project>

# change directory
cd <name-of-your-project>

# build docker image
make docker

# start prefect 
make prefect-start ENV=LOCAL

# restart prefect
make prefect-restart ENV=LOCAL

# reset prefect 
make prefect-reset ENV=LOCAL

# prefect dashboard
http://0.0.0.0:4000/flow-runs
```

