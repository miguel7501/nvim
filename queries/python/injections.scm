(assignment
  left: (identifier) @left (#match? @left "(query|sql)")
  (string (string_content ) @sql
          )
)

; stolen from https://github.com/gmr458/nvim/blob/main/queries/python/injections.scm
(
    [
        (string_content)
    ] @injection.content
    (#match? @injection.content "((SELECT|INSERT|UPDATE|DELETE).+(FROM|INTO|VALUES|SET).*(WHERE|GROUP BY)?)|(ALTER TABLE|DROP).+")
    (#set! injection.language "sql")
)
