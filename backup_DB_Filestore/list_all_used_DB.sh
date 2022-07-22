psql -U postgres -q -c "\l" | awk '{ print $1}' | grep -vE '^\||^-|^List|^Name|template[0|1]|^\('

