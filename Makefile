terraform-files := $(wildcard *.tf)
readme := README.md

all: $(readme)

$(readme): $(terraform-files)
	terraform-docs markdown \
		--output-file $@ \
		--output-mode inject \
		.
