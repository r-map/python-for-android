from pythonforandroid.toolchain import PythonRecipe

class DjangoRecipe(PythonRecipe):
  name = 'django'
  version = '1.10.5'
  url = 'https://pypi.python.org/packages/c3/c2/6096bf5d0caa4e3d5b985ac72e3a0c795e37fa7407d6c85460b2a105b467/Django-{version}.tar.gz'
  MD5_django='3fce02f1e6461fec21f1f15ea7489924'
  depends = ['hostpython2','setuptools']
  site_packages_name = 'django'
  
  patches = ['migration.patch',]
  call_hostpython_via_targetpython = False

  def should_build(self, arch):
    name = self.site_packages_name
    if name is None:
      name = self.name
    return True

recipe = DjangoRecipe()
