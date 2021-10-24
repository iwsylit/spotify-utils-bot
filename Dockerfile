FROM julia:1.6.3-alpine

COPY . /app
WORKDIR app

RUN apk update
RUN julia --project=. -e "using Pkg; Pkg.instantiate()"

CMD ["julia", "--project=.", "run.jl"]
