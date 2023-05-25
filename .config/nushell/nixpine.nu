module nixpine {

  export alias dotfiles = git --git-dir=/home/thomas/.dotfiles/ --work-tree=/home/thomas

  def "nu-complete nixpine users" [] {
    ["thomas" "work"]
  }

  def "nu-complete nixpine generations" [] {
    cd ~
    home-manager generations | lines | each {|| $in | str substring '22,23'}
  }
  
  export def "nixpine build" [
    user: string@"nu-complete nixpine users"
  ] {
    cd ~
    nix run .nixpine switch -- --flake .nixpine
    home-manager switch --flake ($".nixpine#($user)")
  }

  export def "nixpine rev" [
    generation?: string@"nu-complete nixpine generations"
  ] {

    if $generation == null {
      return (home-manager generations | lines)
    }

    let activation_link = (
      home-manager generations | lines | 
      each {|| {rev: ($in | str substring '22,23'), link: ($in | str substring '27,')}} |
      where rev == $generation | get link | first
    )

    if not ($activation_link | is-empty) {
      exec ($activation_link + "/activate")
    }
    
  }
  
}