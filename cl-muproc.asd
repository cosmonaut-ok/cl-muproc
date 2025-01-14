;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

;;; Copyright (c) 2005-2006, Mu Aps. All rights reserved.

;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:

;;;   * Redistributions of source code must retain the above copyright
;;;     notice, this list of conditions and the following disclaimer.

;;;   * Redistributions in binary form must reproduce the above
;;;     copyright notice, this list of conditions and the following
;;;     disclaimer in the documentation and/or other materials
;;;     provided with the distribution.

;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR 'AS IS' AND ANY EXPRESSED
;;; OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;;; GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(in-package #:cl-user)
(defpackage #:cl-muproc.system (:use #:asdf #:cl))
(in-package #:cl-muproc.system)

#-(or lispworks clozure sbcl cmu allegro ecl)
(error "~a: not supported by cl-muproc." (lisp-implementation-type))

(defsystem cl-muproc
  :name "cl-muproc"
  :licence "
;;; Copyright (c) 2005-2006, Mu Aps. All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;;
;;;   * Redistributions of source code must retain the above copyright
;;;     notice, this list of conditions and the following disclaimer.
;;;
;;;   * Redistributions in binary form must reproduce the above
;;;     copyright notice, this list of conditions and the following
;;;     disclaimer in the documentation and/or other materials
;;;     provided with the distribution.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR 'AS IS' AND ANY EXPRESSED
;;; OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;;; GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"
  :author "Klaus Harbo <klaus@mu.dk>"
  :maintainer "Klaus Harbo <klaus@mu.dk>"
  :description "A library for message-passing CL processes, inspired by the Erlang programming language."
  :version "git"
  :depends-on (#+(or sbcl cmu ecl) :bordeaux-threads
               #+(or sbcl cmu ecl) :trivial-timers)
  :components
  ((:module "src"
            :serial t
            :components
            ((:file "packages")
             #+lispworks (:file "muproc-lispworks")
             #+clozure (:file "muproc-clozure")
             #+(or sbcl cmu ecl) (:file "mbox")
             #+(or sbcl cmu ecl) (:file "muproc-bordeaux")
             #+sbcl (:file "muproc-sbcl")
             #+cmu (:file "muproc-cmucl")
             #+allegro (:file "muproc-allegro")
             #+ecl (:file "muproc-ecl")
             (:file "muproc" :depends-on (#+lispworks "muproc-lispworks"
                                          #+clozure "muproc-clozure"
                                          #+(or sbcl cmu ecl) "mbox"
                                          #+(or sbcl cmu ecl) "muproc-bordeaux"
                                          #+sbcl "muproc-sbcl"
                                          #+cmu "muproc-cmucl"
                                          #+allegro "muproc-allegro"
                                          #+ecl "muproc-ecl"))
             (:file "generic-server" :depends-on ("muproc"))
             (:file "supervisor" :depends-on ("muproc"))))))
