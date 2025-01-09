import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { concat } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import emoji from "discourse/helpers/emoji";

export default class WordCard extends Component {
  // const mysteryEmojis = [
  //     "mag", // 🔍
  //     "question", // ❓
  //     "8ball", // 🎱
  //     "crystal_ball", // 🔮
  //     "crescent_moon", // 🌙
  //   ];

  //   const backgroundColors = [
  //     "#FBF5AF",
  //     "#28ABE2",
  //     "#F0794A",
  //     "#E84A51",
  //     "#FBF5AF",
  //   ];

  get randomStyle() {
    return `--rand: ${Math.random()}`;
  }

  get mysteryData() {
    const mysteryEmojis = [
      "mag", // 🔍
      "question", // ❓
      "8ball", // 🎱
      "crystal_ball", // 🔮
      "crescent_moon", // 🌙
    ];

    const backgroundColors = [
      "#FBF5AF",
      "#28ABE2",
      "#F0794A",
      "#E84A51",
      "#FBF5AF",
    ];

    const randomIndex = Math.floor(Math.random() * mysteryEmojis.length);
    return {
      emoji: mysteryEmojis[randomIndex],
      color: `--mystery-color: ${backgroundColors[randomIndex]}`,
    };
  }

  @action
  registerCardContainer(element) {
    this.cardContainer = element;
  }

  @action
  handleClick() {
    this.cardContainer.classList.toggle("flipped");
  }

  <template>
    <div
      {{on "click" (fn this.handleClick)}}
      class="rewind-card__wrapper"
      style={{concat this.randomStyle "; " this.mysteryData.color ";"}}
      {{didInsert this.registerCardContainer}}
    >
      <div class="rewind-card__inner">
        <div class="rewind-card -front">
          <span class="rewind-card__image tl">{{emoji
              this.mysteryData.emoji
            }}</span>
          <span class="rewind-card__image cr">{{emoji
              this.mysteryData.emoji
            }}</span>
          <span class="rewind-card__image br">{{emoji
              this.mysteryData.emoji
            }}</span>
        </div>
        <div class="rewind-card -back">
          <span class="rewind-card__title">{{@word}}</span>
          <span class="rewind-card__data">used {{@count}} times</span>
        </div>
      </div>
    </div>
  </template>
}
