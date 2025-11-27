cd SUPIR

call .\venv\Scripts\activate.bat

cd ..

set HF_HUB_ENABLE_HF_TRANSFER=1

python HF_model_downloader.py --minimal


pause