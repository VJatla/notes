;; publish.el
;; Example Emacs Lisp file to publish your org files using org-publish

(require 'org)
(require 'ox-publish)

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
