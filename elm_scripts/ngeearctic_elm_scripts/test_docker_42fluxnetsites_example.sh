#!/bin/bash

set -e

# Created 2023-10-16 19:43:53

CASEDIR="/output/cime_case_dirs/ELMcpu_42SITES_I1850CNPRDCTCBC"

rm -r "${CASEDIR}"

/E3SM/cime/scripts/create_newcase --case "${CASEDIR}" --mach docker --compset I1850CNPRDCTCBC --res ELM_USRDAT --mpilib openmpi --walltime 4:0:00 --handle-preexisting-dirs u --compiler nvidia

cd "${CASEDIR}"

./xmlchange CIME_OUTPUT_ROOT=/output/cime_run_dirs

./xmlchange ELM_USRDAT_NAME=42_FLUXNETSITES

./xmlchange LND_DOMAIN_FILE=domain_42_FLUXNETSITES_simyr1850_c170912.nc

./xmlchange ATM_DOMAIN_FILE=domain_42_FLUXNETSITES_simyr1850_c170912.nc

./xmlchange DATM_MODE=CLM1PT

./xmlchange DATM_CLMNCEP_YR_START=1901

./xmlchange DATM_CLMNCEP_YR_END=1930

./case.setup --clean

./case.setup

./case.build --clean-all

./case.build

./case.submit

