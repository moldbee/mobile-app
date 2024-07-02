export interface FormattedRoute {
  from: {
    adress: string;
  };
  to: {
    adress: string;
  };
  transport: {
    image: string;
    comforts: {
      wifi: boolean;
      tv: boolean;
      refrigerator: boolean;
      food: boolean;
    };
  };
  company: string;
}
