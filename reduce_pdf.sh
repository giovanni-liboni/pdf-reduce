# Giovanni Liboni - giovanni.liboni@live.it

resolution=""
output_file=""
next_is_output=0
input_file=""

if [ "$#" -eq 0 ]; then
  echo "Specificare un file di input"
  echo "Opzioni disponibili: "
  echo " -o	Specifica un file di output"
  echo " -r	Specifica la risoluzione ( medium / low )"
  exit 0
fi
while [[ $# > 1 ]]
do
	key="$1"
	shift
	case $key in
	    -o|--output)
		output_file="$1"
		shift
	    ;;
	    -r|--resolution)
		echo " Risoluzione $1"
		if [ "$1" == "medium" ]; then
			resolution="ebook"
		elif [ "$1" == "low" ]; then
			resolution="screen"
		fi
		break
	    ;;
	    *)
	    	input_file="$key"
	    ;;
	esac
done
if [ "$output_file" == "" ]
then
	echo "Output: "
	read output_file
fi
if [ "$resolution" == "" ]
then
	echo "Metodo di riduzione :"
	echo "	1. Low-resolution"
	echo "	2. Medium-resolution"
	read c
	case $c in
		1) resolution="screen";;
		2) resolution="ebook";;
		*) resolution="ebook"
	esac
fi
echo "Input file : $input_file"
echo "Output file: $output_file"
echo "Risoluzione: $resolution"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$resolution -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file  
