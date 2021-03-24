#!/bin/bash

function generate_proxy() {
  file=$1

  withoutExtension=$(echo $file | cut -f 1 -d '.')
  echo "export * from './dist/src/$withoutExtension'
export { default } from './dist/src/$withoutExtension'" > $withoutExtension.d.ts
  cp $withoutExtension.d.ts $withoutExtension.js
}

for file in $(ls -p src | grep -v /)
do
  if [ $file == 'index.ts' ]; then
		continue
	fi

  generate_proxy $file
done

generate_proxy "client.ts"