import { createInertiaApp } from "@inertiajs/svelte";
import { mount } from "svelte";
import "../styles/global.css";

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob("../pages/**/*.svelte", {
      eager: true,
    });
    const page = pages[`../pages/${name}.svelte`];
    if (!page) {
      console.error(`Missing Inertia page component: '${name}.svelte'`);
    }

    return page;
  },

  setup({ el, App, props }) {
    if (el) {
      mount(App, { target: el, props });
    } else {
      console.error(
        "Missing root element.\n\n" +
          "If you see this error, it probably means you load Inertia.js on non-Inertia pages.\n" +
          'Consider moving <%= vite_javascript_tag "inertia" %> to the Inertia-specific layout instead.',
      );
    }
  },

  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
    },
    future: {
      useDataInertiaHeadAttribute: true,
      useDialogForErrorModal: true,
      preserveEqualProps: true,
    },
  },
});
