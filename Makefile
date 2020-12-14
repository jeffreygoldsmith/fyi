style:
	bundle exec rubocop -A

gems:
	bundle exec tapioca sync

dsl:
	bundle exec tapioca dsl

tc: typecheck
typecheck:
	bundle exec srb tc

start:
	bundle exec rails server

test:
	bundle exec rails test