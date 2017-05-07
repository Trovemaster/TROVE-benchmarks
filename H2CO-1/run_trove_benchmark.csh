#!/bin/csh
#!
#PBS -V # Pass on to job your whole current environment
#!

setenv wdir $pwd

setenv exec j-trove2109.x


echo $name
echo $nprocs
echo "JOBID = " $PBS_JOBID
#!
setenv OMP_NUM_THREADS $nprocs
setenv MKL_NUM_THREADS $nprocs

echo $nprocs
#!
setenv MKL_DYNAMIC FALSE
setenv KMP_LIBRARY turnaround
setenv OMP_NESTED FALSE
setenv KMP_AFFINITY disabled

#!
hostname
#!
limit
limit datasize unlimited
limit
#!
cd   $pwd
echo $pwd
echo $name
#!
##setenv LAUNCH "time numactl --interleave=all"

setenv LAUNCH "time numactl --interleave=all  dplace -x2"

setenv TMPDIR $wdir
#!
echo "TMPDIR = " $TMPDIR
echo "USER = " $USER
echo "OMP_NUM_THREADS = " $OMP_NUM_THREADS
echo "OMP_NUM_THREADS = " $MKL_NUM_THREADS
echo "PBS_O_WORKDIR" $PBS_O_WORKDIR
#!
echo "wdir" $wdir
#!
cd $wdir
#!
echo $wdir
#!
if (-e $name.out) then
    /bin/rm $name.out
endif
ls $pwd


#!
$LAUNCH $pwd/$exec < $pwd/file1.inp > $pwd/file1.out
$LAUNCH $pwd/$exec < $pwd/file2.inp > $pwd/file2.out
$LAUNCH $pwd/$exec < $pwd/file3.inp > $pwd/file3.out
$LAUNCH $pwd/$exec < $pwd/file4.inp > $pwd/file4.out


#!
echo "DONE"
