function update-all --description 'Update mise, Homebrew, zb, and Mac App Store apps when available'
    if type -q mise
        command mise self-update --yes; or return $status
        command mise up; or return $status
    end

    if type -q brew
        command brew upgrade --yes; or return $status
        command brew upgrade --cask --yes; or return $status
    end

    if type -q zb
        command zb upgrade; or return $status
    end

    if type -q mas
        command mas update; or return $status
    end
end
