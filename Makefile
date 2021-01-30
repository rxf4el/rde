build:
	nixos-rebuild build --flake .

install: switch
	echo "yay!"

acer-a315.out:
	nix build .#acer-a315 -o acer-a315.out --experimental-features "flakes nix-command"

acer-a315/switch: acer-a315.out
	sudo ./acer-a315.out/bin/switch-to-configuration switch
	unlink acer-a315.out

switch:
	sudo nixos-rebuild switch --flake .

repl:
	nix repl src/flake-repl.nix

clean:
	unlink ./result
