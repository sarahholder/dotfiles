alias spark='npm run generate-graphql-types && npm start'
alias typgen='npm run typegen'
alias vdp="npm run typegen && ~/Desktop/cloud_integrations/spark_api/spark-api-appsync/vault-deploy.sh"
# Setup spark envionment and run spark.  Expects user files to be in format $SPARK/.env.<user>
# ex.  `spark-env user env`
## EASY ADD ENVIRONMENT
spark-env() {                    # shoutout to raymondd and andrews for the inspiration
  SPARK=$(z -e edge-spark-react) # -e -- echo output without cd'ing to it
  cd $SPARK
  # spiffy selection menu
  echo ''
  if [ -z "$1" ]; then # if length arg != 0 (not empty string)
    PS3=$'\n'"%F{green}Select an environment:%{$reset_color%} "
    files=($(find . -type f -iname "*.env.*"))
    select file in "${files[@]}"; do
      if [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#files[@]} ]; then
        ENV_FILE=$file
        break
      else
        ERROR="Invalid entry. Select a number between \033[00;32m1\033[0m-\033[00;32m${#files[@]}\033[0m "
        printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $ERROR\n" | boxes -d nuke -a hcvc
      fi
    done
  else
    ENV_FILE=$SPARK/.env.$1
  fi
  MESSAGE="Building Spark with \033[00;32m$ENV_FILE\033[0m variables"
  printf "\033[2K  [ \033[00;32mOK\033[0m ] $MESSAGE" | boxes -d ian_jones -a hcvc
  set -a
  source $ENV_FILE
  # cat $SPARK/.env.$1 > $SPARK/.env ## other option to avoid set
  npm run generate-graphql-types && npm start ## or `spark` alias
}