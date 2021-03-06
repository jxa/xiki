# Helps you define modes.
#
# Sample usage:
#   Mode.define(:deck, ".deck") do
#     Deck.apply_styles
#   end
#
class Mode

  # Easy way to define a mode
  def self.define name, extension, &block

    # Mode function
    $el.defun("#{name}_mode".to_sym, :interactive => "", :docstring => "Apply #{name} styles, etc") {
      $el.el4r_lisp_eval "(setq font-lock-defaults '(nil t))"
      block.call
      $el.use_local_map $el.elvar.send("#{name}_mode_map".to_sym)
    }

    # Associate with file extension
    $el.el4r_lisp_eval %Q<(add-to-list 'auto-mode-alist '("\\\\#{extension}\\\\'" . #{name}-mode))>

  end
end
