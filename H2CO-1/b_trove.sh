#!/bin/bash -l
#

export pwd=`pwd`
echo $pwd

export name=`echo $1 | sed -e 's/\.inp//'`
echo $name

if [ -e "$name.o" ]; then
   /bin/rm $name.o
fi

if [ -e "$name.e" ]; then
   /bin/rm $name.e
fi

if [ -e "$name.out" ]; then
  if [ -e "$name.tmp" ]; then
    /bin/rm $name.tmp
  fi
  /bin/mv $name.out $name.tmp
fi


export dmem=7.3

export PARNODES=$2
export nprocs=`echo $PARNODES | awk  '{printf( "%8.0f\n", 8*$1 )}'`

echo "Nnodes=" $PARNODES, "Nprocs=" $nprocs

export MEM=`echo $nprocs $dmem | awk  '{printf( "%8.0f\n", $2*$1 )}'`

export jobtype="small2"
export wclim=12

if [ $nprocs -lt "8" ]; then
   export jobtype=""
fi

if [ "$nprocs" -gt "63" ]; then
  export jobtype="large2";
  export wclim=12
fi


if [ $nprocs -lt "8" ]; then
   export jobtype=""
fi

#if [ $3 -lt "8" ]; then
#   export wclim=$3
#fi

if [ $3 -gt "12" ] && [ $nprocs -gt "95" ] ; then
   export wclim=$3
   export jobtype="super2"
fi


echo "Nnodes=" $PARNODES, "Nprocs=" $nprocs, " Memory = "$MEM, "jobtype = " $jobtype, "wclimit = " $wclim
echo "Working dir is " $pwd

msub -N $name -o $name.o -e $name.e  -q $jobtype -l "walltime=$wclim:00:00,nodes=$PARNODES:ppn=8" \
     -v "name=$name,pwd=$pwd,nproc=$nprocs" \
     $pwd/run_trove_benchmark.csh

