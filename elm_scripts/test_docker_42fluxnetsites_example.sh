#!/bin/bash

set -e

# Created 2023-10-16 19:43:53

CASEDIR="/output/cime_case_dirs/ELMcpu_42SITES_I1850CNPRDCTCBC"

rm -rf "${CASEDIR}"

/E3SM/cime/scripts/create_newcase --case "${CASEDIR}" --mach docker --compset I1850CNPRDCTCBC --res ELM_USRDAT --mpilib openmpi --walltime 4:0:00 --handle-preexisting-dirs u --compiler gnu

cd "${CASEDIR}"

./xmlchange CIME_OUTPUT_ROOT=/output/cime_run_dirs

./xmlchange ELM_USRDAT_NAME=42_FLUXNETSITES

./xmlchange LND_DOMAIN_FILE=domain_42_FLUXNETSITES_simyr1850_c170912.nc

./xmlchange ATM_DOMAIN_FILE=domain_42_FLUXNETSITES_simyr1850_c170912.nc

./xmlchange DATM_MODE=CLM1PT

./xmlchange DATM_CLMNCEP_YR_START=1980

./xmlchange DATM_CLMNCEP_YR_END=2015

./xmlchange NTASKS=1

./xmlchange NTHRDS=1

echo " 
fsurdat='/inputdata/lnd/clm2/surfdata_map/surfdata_42_FLUXNETSITES_simyr1850_c170912.nc' 
">>user_nl_elm

echo "
 taxmode = 'cycle','extend','extend'
">>user_nl_datm

./case.setup --clean

./case.setup

./case.build --clean-all

./case.build

./case.submit

