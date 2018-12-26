#rm -rf build/
#truffle version
#truffle compile
echo "##### solhint ####"
solhint -V
solhint "contracts/**/*.sol"
echo "#### solium ####" 
solium -V
solium -d contracts/ 


