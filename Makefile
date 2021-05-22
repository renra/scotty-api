.PHONY: test

dev:
	stack exec -- ghcid --command ghci app/Main.hs -T main

test:
	stack exec -- ghcid --command ghci test/Spec.hs -T main
