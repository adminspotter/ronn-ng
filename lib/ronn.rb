# Ronn is a humane text format and toolchain for authoring manpages (and
# things that appear as manpages from a distance). Use it to build /
# install standard Unix roff(7) formatted manpages or to generate
# beautiful HTML manpages.
module Ronn
  autoload :Document, 'ronn/document'
  autoload :Index,    'ronn/index'
  autoload :Template, 'ronn/template'
  autoload :Roff,     'ronn/roff'
  autoload :Server,   'ronn/server'

  # Create a new Ronn::Document for the given ronn file. See
  # Ronn::Document.new for usage information.
  def self.new(filename, attributes = {}, &block)
    Document.new(filename, attributes, &block)
  end

  # truthy when this a release (\d.\d.\d) version.
  def self.release?
    revision != '' && !revision.include?('-')
  end

  # version: 0.6.11
  #
  # A semantic version number based on the git revision. The third element
  # of the version is incremented by the commit offset, such that version
  # 0.6.6-5-gdacd74b => 0.6.11
  def self.version
    ver = revision[/^[0-9.-]+/].split(/[.-]/).map(&:to_i)
    ver[2] += ver.pop while ver.size > 3
    ver.join('.')
  end

  # revision: 0.6.6-5-gdacd74b
  # revision: 0.6.25
  #
  # The string revision as reported by: git-describe --tags. This is just the
  # tag name when a tag references the HEAD commit (0.6.25). When the HEAD
  # commit is not tagged, this is a "<tag>-<offset>-<sha1>" string:
  #   <tag>    - closest tag name
  #   <offset> - number of commits ahead of <tag>
  #   <sha1>   - 7c short SHA1 for HEAD
  def self.revision
    REV
  end

  # value generated by: rake rev
  # or edit manually; I'm not sure of how rake rev interacts with git
  # tags -apjanke
  REV = '0.8.2'.freeze
  VERSION = version
end
