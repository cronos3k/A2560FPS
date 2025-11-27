git clone https://github.com/FurkanGozukara/SUPIR

cd SUPIR

git reset --hard

git pull

python -m venv venv

source ./venv/bin/activate

python -m pip install --upgrade pip

cd ..

pip install -r requirements.txt

export HF_HUB_ENABLE_HF_TRANSFER=1

python HF_model_downloader.py

echo all installed successfully