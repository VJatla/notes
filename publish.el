;; publish.el
;; Example Emacs Lisp file to publish your org files using org-publish

(require 'org)
(require 'ox-publish)

;; Function to convert denote links to file links during export (non-destructive)
(defun convert-denote-links-in-buffer (backend)
  "Convert denote: links to file: links during export without modifying source files."
  (goto-char (point-min))
  ;; Find all denote links: [[denote:IDENTIFIER][Description]]
  (while (re-search-forward "\\[\\[denote:\\([0-9T]+\\)\\]\\[\\([^]]+\\)\\]\\]" nil t)
    (let* ((identifier (match-string 1))
           (description (match-string 2))
           (base-dir (or (and (buffer-file-name)
                              (file-name-directory (buffer-file-name)))
                         default-directory))
           ;; Find the actual file with this identifier
           (files (directory-files base-dir nil (concat "^" identifier "--.*\\.org$"))))
      (when files
        (let ((target-file (car files)))
          ;; Replace denote link with file link in the buffer (temporary)
          (replace-match (format "[[file:%s][%s]]" target-file description) t t))))))

;; Add the conversion function to org export hook
(add-hook 'org-export-before-parsing-hook 'convert-denote-links-in-buffer)

;; Define the org-publish project alist
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/Dropbox/notes/org/"          ; Directory containing your org files
         :base-extension "org"
         :publishing-directory "~/Dropbox/notes/docs/"    ; Output directory for HTML files
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4                        ; Maximum headline depth to export
         :auto-sitemap t                           ; Generate a sitemap automatically
         :sitemap-filename "sitemap.org"           ; Sitemap file name
         :sitemap-title "Sitemap")

	;; Project for copying attachments (images, PDFs, etc.) found alongside org files or in subdirectories like "pics"
        ("attachments"
         :base-directory "~/Dropbox/notes/org/"          ; Same base directory as org files
         :base-extension "png\\|jpg\\|jpeg\\|gif\\|pdf\\|py"
         :publishing-directory "~/Dropbox/notes/docs/"    ; Place attachments in the same output directory structure
         :recursive t
         :publishing-function org-publish-attachment)
	        
        ;; Combined project: includes both org files and static assets
        ("website" :components ("org-notes" "attachments"))))

;; Trigger publishing of all defined projects. The t argument forces a full rebuild.
(org-publish-all t)
