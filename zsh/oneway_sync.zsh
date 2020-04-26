# src=$1 のファイルを dest=$2 に同期する。
echo "[$(cd $(dirname $0); pwd)/$(basename $0)]"
src=${1%/}
dest=${2%/}
echo "(src->dest)=(${src}->${dest})"
for abs_file in ${src}/*(.); do
  file=$(basename ${abs_file})
  echo "<Check ${file}>";

  # dest にファイルがなければコピー
  abs_binfile=${dest}/${file}
  if [[ ! -e ${abs_binfile} ]]; then
    echo "${abs_binfile} not found."
    echo "Copy ${abs_file} --> ${abs_binfile}"
    cp ${abs_file} ${abs_binfile}
  fi

  # dest にファイルがあっても、md5が異なればバックアップを取りつつコピー
  md5_file=$(md5 -q ${abs_file})
  md5_abs_binfile=$(md5 -q ${abs_binfile})
  if [ "${md5_file}" != "${md5_abs_binfile}" ]; then
    echo "md5 doesn't match."
    echo "${abs_file}:${md5_file}"
    echo "${abs_binfile}:${md5_abs_binfile}."

    # ex) Nov 26 19:52:00 2019 => Nov_26_195200_2019
    ts=$(stat -f "%Sm" ${abs_binfile}| sed -e "s/[ ]/_/g"| sed -e "s/://g")
    echo "Backup ${abs_binfile} --> ${abs_binfile}_${ts}"
    cp ${abs_binfile} ${abs_binfile}_${ts}
    echo "Copy ${abs_file} --> ${abs_binfile}"
    cp ${abs_file} ${abs_binfile}
  fi
  echo "<Existence ${abs_binfile}>";
  echo "$(ls -l ${abs_binfile})"
  echo "------------------------------------------------------"
done