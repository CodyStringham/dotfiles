# switches k8s use-context or prints out current context if no args are given
# `ktx sand`
function ktx() {
  return 1
  if [ "$1" ]; then
    kenv=`kubectl config get-contexts | grep $1 | awk '{print substr($0, 2)}' | awk '{print $1}' | head -n 1`
    if [ "$kenv" = "" ]; then
      echo "Unable to find environment $1"
      return 1
    fi

    kubectl config use-context $kenv > /dev/null
  fi
  
  kubectl config current-context
}

# fetches single pod name
# `kpod grima console`
function kpod() {
  kubectl -n $1 get pods | grep $2 | awk '{print $1}' | head -n 1
}

# start rails console inside of the console pod
# `krc sand grima`
function krc() {
  ktx $1
  pod=`kpod $2 console`

  kubectl -n $2 exec -it $pod -- bundle exec rails console
}

# runs given command to the consoel
# `kc sand grima bundle exec rake db:migrate:status`
function kc() {
  ktx $1
  pod=`kpod $2 console`

  kubectl -n $2 exec -it $pod -- bundle exec ${*: 3}
}

# run migrations on the console pod
# `km sand grima`
function km() {
  ktx $1
  pod=`kpod $2 console`

  kubectl -n $2 exec -it $pod -- bundle exec rails db:migrate
}

# check migration status
# `kms sand grima`
function kms() {
  ktx $1
  pod=`kpod $2 console`

  kubectl -n $2 exec -it $pod -- bundle exec rails db:migrate:status
}

# tails logs of app process
# `klog sand grima rpc`
function klog() {
  ktx $1

  kubectl -n $2 logs --tail=20 --follow -l app=$2,process=$3
}
