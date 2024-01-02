GODOT_BIN := /Users/ignas/Downloads/Godot.app/Contents/MacOS/Godot

setup:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

generate: generate-server generate-client
	@echo "Generated"

generate-server:
	@protoc \
		--go_opt=paths=source_relative \
		--go_out=./server/packets ./shared/*.proto

generate-client:
	@cd client && \
		find ../shared -name "*.proto" -exec sh -c '$(GODOT_BIN) --headless -q -s addons/protobuf/protobuf_cmdln.gd --input="{}" --output="net/packets/$$(basename "{}" .proto).gd"' \;

