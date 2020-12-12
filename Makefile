style:
	bundle exec rubocop -A

tc: typecheck
typecheck:
	bundle exec srb tc

start:
	bundle exec rails server

test:
	bundle exec rails test