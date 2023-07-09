# update the list of BEPs in the general BEP question
from pathlib import Path

import ruamel.yaml

yaml = ruamel.yaml.YAML()
yaml.indent(mapping=2, sequence=4, offset=2)

bep_type = ["raw", "derivative", "metadata", "file format"]


def main():
    root = Path(__file__).parent.parent

    input_file = "questions/general_bep.question.md"

    bep_listing = "tools/bids-website/_data/beps.yml"

    with open(root / bep_listing, "r") as f:
        beps = yaml.load(f)

    with open(root / input_file, "r") as f:
        lines = f.readlines()

    with open(root / input_file, "w") as f:
        for line in lines:
            f.write(line)
            if line.startswith("<!-- TEMPLATE STARTS -->"):
                for type_ in bep_type:
                    f.write(f"\n### {type_}\n")
                    for bep_ in beps:
                        if type_ in bep_["content"]:
                            f.write(
                                f"\n- BEP{bep_['number']}: [{bep_['title']}](https://bids.neuroimaging.io/bep{bep_['number']})"
                            )
                break


if __name__ == "__main__":
    main()
