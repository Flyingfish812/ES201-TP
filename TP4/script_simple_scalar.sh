#!/bin/bash

SIM_PROFILE=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-profile
SIM_OUTORDER=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder
PRG_SS="prodmatrix.ss"
REDIR_OUT_SIM="-redir:sim /Outputs/profile_output.txt"
OPTIONS="-iclass -iprof"

$SIM_PROFILE $REDIR_OUT_SIM $OPTIONS $PRG_SS
# $SIM_OUTORDER $REDIR_OUT_SIM $PRG_SS