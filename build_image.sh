#docker image build -t serverdev .
#docker image build -t serverruntime:21021801 . -f Dockerfile.runtime
docker image build -t serverdev:gcc14 . -f Dockerfile.gcc14
