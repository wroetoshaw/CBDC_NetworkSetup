source queryInstallated.sh 
function allqueryInstalled() {
    queryInstalled 0 centralbank
    queryInstalled 0 commercialbank
    queryInstalled 1 commercialbank
    queryInstalled 0 consumer
    queryInstalled 1 consumer
    queryInstalled 2 consumer

}