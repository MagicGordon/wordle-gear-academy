build: build-wordle build-game-session

build-wordle: wordle
	cargo build -p wordle --release

build-game-session: game-session
	cargo build -p game-session --release

test:
	make test