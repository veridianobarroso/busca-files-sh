#!/bin/bash

root_directory="/media/usuario/nomedaunidadeexterna"
imagem=0
videos=0
docs=0
traverse_directory(){
	local current_directory="$1"
	for file_or_directory in "$current_directory"/*; do
	 	#echo $file_or_directory
	 	if [ -d "$file_or_directory" ]; then
			echo "pasta: $file_or_directory"
			traverse_directory "$file_or_directory"
		elif [ -f "$file_or_directory"  ]; then
			file_size=$(stat -c %s "$file_or_directory")
			# Converte o tamanho para kilobytes
			file_size_kb=$((file_size / 1024))
			# Define o limite para 10 KB
			limit_kb=10
			if [ "$file_size_kb" -gt "$limit_kb" ]; then			
				file_extension="${file_or_directory##*.}"
					if [ -n "$file_extension" ]; then				
						if [ $file_extension = "png" ] || [ $file_extension = "jpg" ] || [ $file_extension = "webp" ]; then
						#echo "arquivo: $file_or_directory - tamanho: $file_size_kb kb"
							cp "$file_or_directory" "/media/usuario/nomedaunidadeexterna/IMAGENS"
							 
							imagem=$((imagem + 1))
							
						fi
						if [ $file_extension = "zip" ] || [ $file_extension = "txt" ] || [ $file_extension = "doc" ] || [ $file_extension = "docx" ] || [ $file_extension = "xls" ] || [ $file_extension = "xlsx" ]; then
						#echo "arquivo: $file_or_directory - tamanho: $file_size_kb kb"
							cp "$file_or_directory" "/media/usuario/nomedaunidadeexterna/DOCS/"
							docs=$((docs + 1))
							 
						fi
						if [ $file_extension = "mp4" ] || [ $file_extension = "wmv" ] || [ $file_extension = "mkv" ] || [ $file_extension = "3gp" ] || [ $file_extension = "mov" ] || [ $file_extension = "mpeg"  ]; then
						#echo "arquivo: $file_or_directory - tamanho: $file_size_kb kb"
							cp "$file_or_directory" "/media/usuario/nomedaunidadeexterna/VIDEOS/"
							videos=$((videos + 1))
							 
						fi
					fi
					#resumo
					echo "Imagem: $imagem - Docs: $docs - Videos: $videos"
			fi
		fi
	done
}
traverse_directory "$root_directory"
