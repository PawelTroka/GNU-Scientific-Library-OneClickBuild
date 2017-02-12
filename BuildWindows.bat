setlocal
cd /d %~dp0

Powershell.exe -executionpolicy remotesigned -File BuildWindows.ps1

::x86
cd gsl-x86
cmake -DBUILD_SHARED_LIBS=ON .

::#x64
cd ..
cd gsl-x64
cmake -G "Visual Studio 14 2015 Win64" -DBUILD_SHARED_LIBS=ON .
cd ..

"C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" "gsl-x86/gsl.vcxproj" /p:Configuration=Release

"C:\Program Files (x86)\MSBuild\14.0\Bin\amd64\MSBuild.exe" "gsl-x64/gsl.vcxproj" /p:Configuration=Release

::xcopy /s/e /v /y /z "gsl-x86/*.dll" "bin-x86"
::xcopy /s/e /v /y /z "gsl-x64/*.dll" "bin-x64"

mkdir bin-x86
for /R "gsl-x86\" %%f in (*.dll) do copy %%f "bin-x86\"
mkdir bin-x64
for /R "gsl-x64\" %%f in (*.dll) do copy %%f "bin-x64\"
pause