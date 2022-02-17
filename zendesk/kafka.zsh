kfka () {
  zdi kafka_protobuf run \
    --topic=$1 \
    --pretty \
    -- \
    --from-beginning
}