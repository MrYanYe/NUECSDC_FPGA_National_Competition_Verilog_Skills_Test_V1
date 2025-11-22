import os
import sys
import shutil

'''
将当前目录（与本 .py 同层）及其所有子目录中的 .v 文件复制为内容不变的 .txt 文件，
并保存到与 .py 同级的一个新建输出文件夹中。
输出文件夹名由当前脚本所在目录的前两级父目录名 + 基础输出名 组成：
例如：aaa/bbb/df.py -> 输出文件夹名 "aaa_bbb_Verilog_to_txt_Output"
如果父级不足两级，则使用能取得的级名作为前缀。
'''

# ========== 配置区域 ==========
PRESERVE_STRUCTURE = True
BASE_OUTPUT_FOLDER = "Verilog_to_txt_Output"
# ==============================

def get_real_base_dir():
    """
    返回实际运行目录：
    - 如果是打包后的 exe，返回 exe 所在目录
    - 如果是普通 .py，返回脚本所在目录
    """
    if getattr(sys, 'frozen', False):  # 打包后的 exe
        return os.path.dirname(sys.executable)
    else:  # 普通脚本
        return os.path.dirname(os.path.abspath(__file__))

def prepare_output_folder(base_dir, folder_name):
    output_dir = os.path.join(base_dir, folder_name)
    if os.path.exists(output_dir):
        print(f"检测到已有文件夹 {output_dir}，正在删除...")
        shutil.rmtree(output_dir)
    os.makedirs(output_dir, exist_ok=True)
    return output_dir

def get_unique_filename(path):
    if not os.path.exists(path):
        return path
    base, ext = os.path.splitext(path)
    counter = 2
    new_path = f"{base}({counter}){ext}"
    while os.path.exists(new_path):
        counter += 1
        new_path = f"{base}({counter}){ext}"
    return new_path

def make_output_folder_name_from_parents(current_dir, base_name):
    norm = os.path.normpath(os.path.abspath(current_dir))
    parts = norm.split(os.sep)
    if len(parts) >= 2:
        p1 = parts[-2]
        p2 = parts[-1]
        prefix = f"{p1}_{p2}"
    elif len(parts) == 1:
        prefix = parts[-1] or "Output"
    else:
        prefix = "Output"
    prefix = prefix.replace(" ", "_") if prefix else "Output"
    return f"{prefix}_{base_name}"

def convert_v_to_txt(base_dir):
    current_dir = os.path.abspath(base_dir)
    output_folder_name = make_output_folder_name_from_parents(current_dir, BASE_OUTPUT_FOLDER)
    output_dir = prepare_output_folder(current_dir, output_folder_name)

    for root, dirs, files in os.walk(current_dir):
        try:
            if os.path.commonpath([os.path.abspath(root), os.path.abspath(output_dir)]) == os.path.abspath(output_dir):
                continue
        except ValueError:
            pass

        for file in files:
            if file.lower().endswith(".v"):
                v_file_path = os.path.join(root, file)
                if PRESERVE_STRUCTURE:
                    relative_path = os.path.relpath(root, current_dir)
                    target_dir = os.path.join(output_dir, relative_path)
                    os.makedirs(target_dir, exist_ok=True)
                    txt_file_name = os.path.splitext(file)[0] + ".txt"
                    txt_file_path = os.path.join(target_dir, txt_file_name)
                else:
                    txt_file_name = os.path.splitext(file)[0] + ".txt"
                    txt_file_path = os.path.join(output_dir, txt_file_name)

                txt_file_path = get_unique_filename(txt_file_path)

                try:
                    with open(v_file_path, "r", encoding="utf-8", errors="ignore") as f_in:
                        content = f_in.read()
                    with open(txt_file_path, "w", encoding="utf-8") as f_out:
                        f_out.write(content)
                    print(f"转换完成: {v_file_path} -> {txt_file_path}")
                except Exception as e:
                    print(f"处理文件 {v_file_path} 时出错: {e}")

if __name__ == "__main__":
    current_dir = get_real_base_dir()
    convert_v_to_txt(current_dir)
    print(f"\n所有 .v 文件已转换完成，结果保存在与脚本同级的文件夹: {make_output_folder_name_from_parents(current_dir, BASE_OUTPUT_FOLDER)}")
